package services

import (
	"strconv"

	"github.com/Mahaveer86619/Lumi/src/config"
	"gopkg.in/gomail.v2"
)

func SendHTMLEmail(to string, subject string, body string) (string, error) {
	from := config.GMAIL
	password := config.GMAIL_APP_PASS

	toList := []string{to}

	host := config.SMTP_HOST
	port_str := config.SMTP_PORT
	port, err := strconv.ParseInt(port_str, 10, 64)
	if err != nil {
		return "", err
	}

	m := gomail.NewMessage()
	m.SetHeader("From", from)
	m.SetHeader("To", toList...)
	// m.SetAddressHeader("Cc", "dan@example.com", "Dan")
	m.SetHeader("Subject", subject)
	m.SetBody("text/html", body)
	// m.Attach("/home/Alex/lolcat.jpg")

	d := gomail.NewDialer(host, int(port), from, password)

	if err := d.DialAndSend(m); err != nil {
		return "", err
	} else {
		return "Email sent successfully", nil
	}
}
