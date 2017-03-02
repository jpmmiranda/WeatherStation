require 'socket'


class Servidor
  def initialize(port)
  	@port = port
  end

  def start
  	server = TCPServer.open(@port)
	  loop {
	    Thread.start(server.accept) do |client|

	      # Faz coisas
	      puts "Cliente : #{client} conectou-se ao sistema"
	      while true do
	      	leitura = client.gets.chomp
	      	if(leitura == "Fim")
	      		client.close
		      	puts "Cliente : #{client} desconectou-se do sistema"
		    else
	  	  		puts "#{client}: #{leitura}"
	  	  	end
	      end

	    end
	  }
  end

  def listarClientes #Apresenta lista de clientes que estão ligados e a sua localização

  end

  def valoresSensorTemperatura(cliente) # Apresentar valores recolhidos de temperatura de um dado xdk
  	
  end


  def valoresSensorAcustica(cliente) # Apresentar valores recolhidos de acustica de um dado xdk

  end

end

# Signal catching
def shut_down
  puts "\nShutting down server..."
  sleep 1
end

# Trap ^C 
Signal.trap("INT") { 
  shut_down
  exit
}

# Trap `Kill `
Signal.trap("TERM") {
  shut_down
  exit
}

server = Servidor.new(8000)
server.start