package web

import (
	"log"
	"net/http"

	"github.com/Mahaveer86619/Lumi/src/config"
)

type Server struct {
	port string
}

func NewServer() *Server {
	return &Server{}
}

func (s *Server) Init() {
	s.port = config.PORT
	routes := SetupRoutes()
	http.Handle("/", routes)
}

func (s *Server) Start() {
	log.Printf("Server starting on port %s", s.port)
	log.Fatal(http.ListenAndServe(":"+s.port, nil))
}
