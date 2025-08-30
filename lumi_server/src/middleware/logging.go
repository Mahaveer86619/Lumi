package middleware

import (
	"net/http"
	"time"

	"github.com/Mahaveer86619/Lumi/src/utils"
)

// LoggingMiddleware logs incoming HTTP requests with structured data.
func LoggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		// Wrap the response writer to capture the status code
		wrappedWriter := &responseWriter{ResponseWriter: w, statusCode: http.StatusOK}

		// Call the next handler
		next.ServeHTTP(wrappedWriter, r)

		// Log the request details
		utils.AppLogger.Info("%s %s %d %s", r.Method, r.URL.Path, wrappedWriter.statusCode, time.Since(start).String())
	})
}

// responseWriter is a wrapper for http.ResponseWriter to capture the status code.
type responseWriter struct {
	http.ResponseWriter
	statusCode int
}

func (rw *responseWriter) WriteHeader(code int) {
	rw.statusCode = code
	rw.ResponseWriter.WriteHeader(code)
}
