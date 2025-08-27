package middleware

import (
	"net/http"
	"sync"
	"time"
)

type rateLimiter struct {
	tokens     int
	lastRefill time.Time
	mu         sync.Mutex
}

var (
	rateLimiters = make(map[string]*rateLimiter)
	rateLimitMu  sync.Mutex
	rateLimit    = 10 // requests per minute per IP
	burstLimit   = 10
)

func RateLimitMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ip := r.RemoteAddr
		rateLimitMu.Lock()
		limiter, ok := rateLimiters[ip]
		if !ok {
			limiter = &rateLimiter{tokens: burstLimit, lastRefill: time.Now()}
			rateLimiters[ip] = limiter
		}
		rateLimitMu.Unlock()

		limiter.mu.Lock()
		// refill tokens
		now := time.Now()
		elapsed := now.Sub(limiter.lastRefill)
		refill := int(elapsed.Minutes()) * rateLimit
		if refill > 0 {
			limiter.tokens = min(burstLimit, limiter.tokens+refill)
			limiter.lastRefill = now
		}
		if limiter.tokens > 0 {
			limiter.tokens--
			limiter.mu.Unlock()
			next.ServeHTTP(w, r)
			return
		}
		limiter.mu.Unlock()
		http.Error(w, "Too Many Requests", http.StatusTooManyRequests)
	})
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}