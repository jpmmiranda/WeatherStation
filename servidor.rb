require 'socket'


class Servidor
  server = TCPServer.open(8000)
  loop {
    Thread.start(server.accept) do |client|

      # Faz coisas
      puts "Cliente : #{client} conectou-se ao sistema"
      client.close
      puts "Cliente : #{client} desconectou-se do sistema"

    end
  }

  def listarClientes #Apresenta lista de clientes que estão ligados e a sua localização

  end

  def valoresSensorTemperatura(cliente) # Apresentar valores recolhidos de temperatura de um dado xdk

  end


  def valoresSensorAcustica(cliente) # Apresentar valores recolhidos de acustica de um dado xdk

  end

end