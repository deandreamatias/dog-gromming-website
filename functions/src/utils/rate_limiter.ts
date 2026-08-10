/**
 * Simple in-memory IP based rate limiter.
 *
 * NOTE: Cloud Functions may run across multiple instances, so this limiter is
 * best-effort per instance. For a strict global limit, switch to a shared
 * backend (Firestore counters or Memorystore).
 */

const WINDOW_MS = 60 * 60 * 1000; // 1 hour
const MAX_PER_WINDOW = 3;

interface RateWindow {
  count: number;
  resetAt: number;
}

const buckets = new Map<string, RateWindow>();

/** Returns true when the request is allowed for the given client IP. */
export function isAllowed(ip: string): boolean {
  if (!ip) {
    return false;
  }
  const now = Date.now();
  const bucket = buckets.get(ip);
  if (bucket === undefined) {
    buckets.set(ip, { count: 1, resetAt: now + WINDOW_MS });
    return true;
  }
  if (now > bucket.resetAt) {
    bucket.count = 1;
    bucket.resetAt = now + WINDOW_MS;
    return true;
  }
  bucket.count += 1;
  return bucket.count <= MAX_PER_WINDOW;
}

/** Remove expired windows to avoid unbounded memory growth. */
export function cleanupExpired(): void {
  const now = Date.now();
  for (const [ip, bucket] of buckets) {
    if (now > bucket.resetAt) {
      buckets.delete(ip);
    }
  }
}