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


end

#Criação de clientes
c1=Cliente.new(41.569504,-8.433332)
#c2=Cliente.new(41.570345,-8.895043)

# Signal catching
def shut_down
  puts "\nShutting down..."
  sleep 1
end

# Trap ^C 
Signal.trap("INT") { 
  shut_down 
  c1.enviaFim
  exit
}

# Trap `Kill `
Signal.trap("TERM") {
  shut_down
  c1.enviaFim
  exit
}

threadTemp = Thread.new{
	c1.geraTemp
}
threadNoise = Thread.new{
	c1.geraAcust
}

threadNoise.join
threadTemp.join


