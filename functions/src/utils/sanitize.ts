export const FIELD_LIMITS = {
  name: 100,
  contactMethod: 100,
  petName: 100,
  petSize: 20,
  message: 2000,
} as const;

export interface WebsiteContact {
  name: string;
  contactMethod: string;
  petName: string;
  whatsappCheckbox: boolean;
  petSize: string;
  message: string;
  privacyPolicyCheckbox: boolean;
}

export interface ContactValidationResult {
  contact: WebsiteContact;
  isBot: boolean;
}

const ESCAPE_PATTERNS: Array<[RegExp, string]> = [
  [/&/g, '&amp;'],
  [/</g, '&lt;'],
  [/>/g, '&gt;'],
  [/"/g, '&quot;'],
  [/'/g, '&#39;'],
];

/** Escape a string so it is safe to embed in an HTML email body. */
export function escapeHtml(value: string): string {
  let result = value;
  for (const [pattern, replacement] of ESCAPE_PATTERNS) {
    result = result.replace(pattern, replacement);
  }
  return result;
}

// RFC 5322 addr-spec pattern, identical to the one used by the Flutter client
// (lib/ui/utils/validators_util.dart). Keeps frontend and backend in agreement.
const EMAIL_PATTERN =
  /^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/;

function isEmail(value: string): boolean {
  return EMAIL_PATTERN.test(value.toLowerCase());
}

export { isEmail, isPhone };

/**
 * E.164-ish phone check. Separators are stripped before matching, so
 * "+34 654 477 396", "654477396" and "+35191 234 5678" all pass.
 */
function isPhone(value: string): boolean {
  // eslint-disable-next-line no-control-regex
  const normalized = value.replace(/[\s().\-]/g, '');
  return /^\+?\d{6,15}$/.test(normalized);
}

function invalid(field: string, reason: string): Error {
  return new Error(`${field} ${reason}`);
}

function requiredString(value: unknown, field: string, max: number): string {
  if (typeof value !== 'string' || value.trim().length === 0) {
    throw invalid(field, 'is required');
  }
  if (value.length > max) {
    throw invalid(field, 'exceeds the maximum length');
  }
  return value.trim();
}

function optionalString(value: unknown, field: string, max: number): string {
  if (value === undefined || value === null) {
    return '';
  }
  if (typeof value !== 'string' || value.length > max) {
    throw invalid(field, 'is invalid or exceeds the maximum length');
  }
  return value.trim();
}

function optionalBoolean(value: unknown, field: string): boolean {
  if (value === undefined || value === null) {
    return false;
  }
  if (typeof value !== 'boolean') {
    throw invalid(field, 'must be a boolean');
  }
  return value;
}

/**
 * Validate and normalize the incoming request body into a WebsiteContact.
 *
 * If `honeypotWebsite` is a non-empty string, the request is considered a bot
 * and the returned `isBot` flag lets the caller drop it silently.
 */
export function parseAndValidateContact(
  body: unknown,
): ContactValidationResult {
  const raw = (body ?? {}) as Record<string, unknown>;

  const isBot = typeof raw.websiteHp === 'string' && raw.websiteHp.length > 0;

  const privacyPolicyCheckbox = requiredBoolean(raw.privacyPolicyCheckbox);
  if (!privacyPolicyCheckbox) {
    throw invalid('privacyPolicyCheckbox', 'must be accepted');
  }

  const contactMethod = requiredString(raw.contactMethod, 'contactMethod', FIELD_LIMITS.contactMethod);
  if (!isEmail(contactMethod) && !isPhone(contactMethod)) {
    throw invalid('contactMethod', 'must be a valid email or phone number');
  }

  const contact: WebsiteContact = {
    name: requiredString(raw.name, 'name', FIELD_LIMITS.name),
    contactMethod,
    petName: optionalString(raw.petName, 'petName', FIELD_LIMITS.petName),
    whatsappCheckbox: optionalBoolean(raw.whatsappCheckbox, 'whatsappCheckbox'),
    petSize: optionalString(raw.petSize, 'petSize', FIELD_LIMITS.petSize),
    message: optionalString(raw.message, 'message', FIELD_LIMITS.message),
    privacyPolicyCheckbox,
  };

  return { contact, isBot };
}

function requiredBoolean(value: unknown): boolean {
  if (typeof value !== 'boolean') {
    throw invalid('privacyPolicyCheckbox', 'must be a boolean');
  }
  return value;
}