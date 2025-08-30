package utils

import (
	"fmt"
	"io"
	"log"
	"os"
	"runtime"
	"strings"
	"time"
)

type CustomLogger struct {
	InfoLogger  *log.Logger
	DevLogger   *log.Logger
	ErrorLogger *log.Logger
}

func New(output io.Writer) *CustomLogger {
	flags := 0

	formatter := func(level string, prefix string) string {
		_, file, line, ok := runtime.Caller(3)
		if !ok {
			file = "???"
			line = 0
		}

		parts := strings.Split(file, "/")
		var shortPath string
		if len(parts) >= 2 {
			shortPath = strings.Join(parts[len(parts)-2:], "/")
		} else {
			shortPath = parts[len(parts)-1]
		}

		// Format: YYYY/MM/DD HH:MM:SS 🟢 [LEVEL] >> filename.go:line_number message
		return fmt.Sprintf(
			"--------------------------------------------------\n%s %s [%s] >> %s:%d ", 
			time.Now().Format("2006/01/02 15:04:05"), 
			prefix, 
			level, 
			shortPath, 
			line,
		)
	}

	infoPrefix := "INFO"
	devPrefix := "DEV"
	errorPrefix := "ERROR"

	return &CustomLogger{
		InfoLogger:  log.New(output, formatter(infoPrefix, "🟢"), flags),
		DevLogger:   log.New(output, formatter(devPrefix, "🔵"), flags),
		ErrorLogger: log.New(os.Stderr, formatter(errorPrefix, "🔴"), flags),
	}
}

// These wrapper functions simplify logging by removing the need to call Println/Printf on the logger object directly.

// Info logs an informational message.
func (cl *CustomLogger) Info(format string, v ...interface{}) {
	cl.InfoLogger.Output(3, fmt.Sprintf(format, v...))
}

// Dev logs a development/debug message.
func (cl *CustomLogger) Dev(format string, v ...interface{}) {
	cl.DevLogger.Output(3, fmt.Sprintf(format, v...))
}

// Error logs an error message.
func (cl *CustomLogger) Error(format string, v ...interface{}) {
	cl.ErrorLogger.Output(3, fmt.Sprintf(format, v...))
}

var AppLogger *CustomLogger

func init() {
	AppLogger = New(os.Stdout)
}
