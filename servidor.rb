class Servidor
  require 'socket'

  server = TCPServer.open(8000)
  loop {
    Thread.start(server.accept) do |client|

      # Faz coisas
      puts "Cliente : #{client} conectou-se ao sistema"
      client.close
      puts "Cliente : #{client} desconectou-se do sistema"

    end
  }
end