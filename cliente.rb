require 'socket'


class Cliente

  def initialize(longitude,latitude)
    s = TCPSocket.open('localhost', 8000)
    @longitude = longitude #longitude do xdk
    @latitude = latitude #latitude do xdk
  end


  def enviaDadosTemp  #Envia a cada 2 segundos

  end



  def enviaDadosAcust    #Envia a cada 30 segundos

  end

  def geraTemp
    @temperatura = rand(-10...50)
  end

  def geraAcust
    @acustica = rand(-10...50) #nao sei gama de valores
  end


end



#Criação de clientes
c1=Cliente.new(41.569504,-8.433332)
c2=Cliente.new(41.570345,-8.895043)
