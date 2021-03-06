require 'socket'


class Cliente

  def initialize(longitude,latitude)
    @s = TCPSocket.open('localhost', 8000)
    @longitude = longitude #longitude do xdk
    @latitude = latitude #latitude do xdk
    enviaCoords
  end


  def enviaFim
  	@s.puts "Fim"
  end

  def enviaCoords
    @s.puts @longitude
    @s.puts @latitude
  end

  def geraTemp
  	readingTemp = rand(30) #gama provavelmente incorreta

		while true do
			sleep 30
			if(rand(2) == 1)
				readingTemp += 1
			else
				readingTemp -= 1 
			end
      time = Time.now.getutc
      @s.puts "T"
			@s.puts readingTemp
      @s.puts time
		end

  end

  def geraAcust
  	readingNoise = rand(300) #gama provavelmente incorreta

		while true do
			sleep 1
			if(rand(2) == 1)
				readingNoise += 50
			else
				readingNoise -= 50 
			end
			time = Time.now.getutc
      @s.puts "R"
      @s.puts readingNoise
      @s.puts time
      
		end
  end

  def servidorClose
  	while true do
  		mensagem = @s.gets.chomp
  		if mensagem == "Fim"
  			@s.close
  			puts "Servidor desligou-se."
  			puts "Shutting down..."
  			exit
  		end
  	end
  end


end

#Criação de clientes
c=Cliente.new(ARGV[0],ARGV[1])

# Signal catching
def shut_down
  puts "\nShutting down..."
  sleep 1
end

# Trap ^C 
Signal.trap("INT") { 
  shut_down 
  c.enviaFim
  exit
}

# Trap `Kill `
Signal.trap("TERM") {
  shut_down
  c.enviaFim
  exit
}

threadTemp = Thread.new{
	c.geraTemp
}
threadNoise = Thread.new{
	c.geraAcust
}

threadMensagem = Thread.new{
	c.servidorClose
}

threadNoise.join
threadTemp.join
threadMensagem.join


