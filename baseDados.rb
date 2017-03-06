  require 'mysql'

  class BaseDados

    def initialize(hostname,username,password,databasename)
        @con = Mysql.new(hostname, username,password, databasename)  
    end

    def close
        @con.close
    end

    def verificaClienteExiste(long,lat)
        rs = @con.query("SELECT count(*) from Local where Longitude= " + long + 
          " and Latitude= " + lat)
        total = rs.fetch_row 
        if(total[0] == '0') 
          rs = @con.query 'insert into Local values ( ' + long  + ', ' + lat + ')' 
        end
    end

    def adicionaRegistoTemperatura(leitura,timestamp,long,lat)
       rs = @con.query 'insert into Registos (Temperatura, Data,Local_Longitude,Local_Latitude) values ( ' +   
            leitura + ", '#{timestamp}'" + ', ' + long + ', ' + lat + ')' 

    end


    def adicionaRegistoRuido(leitura,timestamp,long,lat)
      rs = @con.query 'insert into Registos (Ruído, Data,Local_Longitude,Local_Latitude) values ( ' +   
            leitura + ", '#{timestamp}'" + ', ' + long + ', ' + lat + ')'
    end
  end
