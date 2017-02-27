class Cliente
  require 'socket'

  def initialize
    s = TCPSocket.open('localhost', 8000)
    @longitude = rand(-180.000..180.000) #longitude do xdk
    @latitude = rand(-90.000..90.000) #latitude do xdk
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

c = Cliente.new