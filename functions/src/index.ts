/* eslint-disable @typescript-eslint/no-explicit-any */

import { onRequest } from 'firebase-functions/v2/https';
import { logger } from 'firebase-functions';
import { Resend } from 'resend';
import {
  escapeHtml,
  isEmail,
  parseAndValidateContact,
} from './utils/sanitize';
import { cleanupExpired, isAllowed } from './utils/rate_limiter';

// Keep the compiled limiter buckets tidy between invocations.
cleanupExpired();

const ALLOWED_ORIGIN = 'https://peluqueriacaninamimos.com';
const DESTINATION_EMAIL = 'contacto@peluqueriacaninamimos.com';
const FROM_ADDRESS = `${'Peluquería Mimos'} <${DESTINATION_EMAIL}>`;
const REQUEST_BODY_LIMIT = 8192;

function sendError(response: { status: (code: number) => any }, code: number, message: string): void {
  response.status(code).json({ error: message });
}

function buildHtmlBody(contact: any): string {
  const safe = (value: string): string => {
    const text = escapeHtml(value);
    return text.length === 0 ? '—' : text;
  };

  const rows: Array<[string, string]> = [
    ['Nombre', safe(contact.name)],
    ['Contacto', safe(contact.contactMethod)],
    ['Nombre de la mascota', safe(contact.petName)],
    [
      'Tamaño de la mascota',
      safe(contact.petSize),
    ],
    [
      '¿Prefiere WhatsApp?',
      contact.whatsappCheckbox ? 'Sí' : 'No',
    ],
    ['Mensaje', safe(contact.message) || '—'],
  ];

  const rowsHtml = rows
    .map(
      ([label, value]) =>
        `<tr><td style="padding:8px 0;font-weight:600;vertical-align:top;color:#555;">${label}</td>` +
        `<td style="padding:8px 0;padding-left:16px;">${value}</td></tr>`,
    )
    .join('');

  return (
    '<table role="presentation" style="font-family:Arial,sans-serif;font-size:15px;color:#222;' +
    'max-width:600px;width:100%;border-collapse:collapse;">' +
    rowsHtml +
    '</table>'
  );
}

export const sendEmail = onRequest(
  { secrets: ['RESEND_API_KEY'], cors: [ALLOWED_ORIGIN] },
  async (req, res) => {
    const ip = req.ip ?? '';

    // Anti-abuse: drop requests that exceed the per-IP rate limit.
    if (!isAllowed(ip)) {
      res.status(429).json({ error: 'Too many requests' });
      return;
    }

    if (req.method !== 'POST') {
      sendError(res, 405, 'Method not allowed');
      return;
    }

    if (req.headers['content-length'] &&
      Number(req.headers['content-length']) > REQUEST_BODY_LIMIT) {
      sendError(res, 413, 'Payload too large');
      return;
    }

    let result;
    try {
      result = parseAndValidateContact(req.body);
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Invalid input';
      logger.warn('Rejected contact form submission', { reason: message });
      sendError(res, 400, message);
      return;
    }

    // Honeypot triggered: silently pretend success, never send the email.
    if (result.isBot) {
      res.status(200).json({ success: true });
      return;
    }

    const { contact } = result;

    const subject = `Nuevo mensaje de ${contact.name}`;

    const replyTo = isEmail(contact.contactMethod)
      ? contact.contactMethod
      : DESTINATION_EMAIL;

    try {
      const resend = new Resend(process.env.RESEND_API_KEY);

      const { error } = await resend.emails.send({
        from: FROM_ADDRESS,
        to: [DESTINATION_EMAIL],
        replyTo: [replyTo],
        subject,
        html: buildHtmlBody(contact),
        text: `${contact.name}\n${contact.contactMethod}\n${contact.message}`,
      });

      if (error) {
        logger.error('Resend rejected the email', { error: error.message });
        sendError(res, 500, 'Failed to send email');
        return;
      }

      // No PII is logged: only a generic success status.
      logger.info('Contact email sent');
      res.status(200).json({ success: true });
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Unknown error';
      logger.error('Failed to send email', { error: message });
      sendError(res, 500, 'Failed to send email');
    }
  },
);