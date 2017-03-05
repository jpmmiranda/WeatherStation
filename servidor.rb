  require 'socket'
  require 'mysql'
  require './baseDados'

  class Servidor

    def initialize(port)
      	@server = TCPServer.open(port)  
        #my = Mysql.new(hostname, username, password, databasename)  
        @bd = BaseDados.new('localhost', 'root', 'ruiborges', 'Leituras')  
    end

    def start
  	  loop {
  	    Thread.start(@server.accept) do |client|
  	   	  contadorLeituras = -1 
  	      # Faz coisas
          long = client.gets.chomp
          lat = client.gets.chomp
  	      puts "Cliente com longitude #{long} e latitude #{lat} conectou-se ao sistema"
          @bd.verificaClienteExiste(long,lat)
  	      while true do
  	      	leitura = client.gets.chomp
  	      	contadorLeituras = contadorLeituras + 1
  	      	if(leitura == "Fim")
  	      		client.close
  		      	puts "Cliente : longitude #{long} e latitude #{lat} desconectou-se do sistema com #{contadorLeituras} leituras."
  		    else
  	  	  		puts "Cliente com longitude #{long} e latitude #{lat}: #{leitura}"
  	  	  	end
  	      end

  	    end
  	  }
    end

      def close
        @bd.close
      	@server.close
      end

      

      def listarClientes #Apresenta lista de clientes que estão ligados e a sua localização

      end

      def valoresSensorTemperatura(cliente) # Apresentar valores recolhidos de temperatura de um dado xdk
      	
      end


      def valoresSensorAcustica(cliente) # Apresentar valores recolhidos de acustica de um dado xdk

      end

  end

  server = Servidor.new(8000)

  # Signal catching
  def shut_down
    puts "\nShutting down server..."
  end

  # Trap ^C 
  Signal.trap("INT") { 
    shut_down
    server.close
    exit
  }

  # Trap `Kill `
  Signal.trap("TERM") {
    shut_down
    server.close
    exit
  }

  server.start