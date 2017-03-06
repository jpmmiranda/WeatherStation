  require 'mysql'

  class BaseDados

    def initialize(hostname,username,password,databasename)
        @con = Mysql.new(hostname, username,password, databasename)  
    end

    def close
        @con.close
    end

    def verificaClienteExiste(long,lat)
        rs = @con.query("SELECT COUNT(*) from local where longitude= " + long + 
          " and latitude= " + lat)
       
        total = rs.fetch_row 
        if(total==0) 
          rs = @con.query 'insert into local values ( ' + long  + ', ' + lat + ')' 
        end
    end

    def adicionaRegistoTemperatura(leitura,timestamp,long,lat)

       rs = @con.query 'insert into registos (temperatura, data,local_longitude,local_latitude) values ( ' +   
            leitura + ", '#{timestamp}'" + ', ' + long + ', ' + lat + ')' 
      
    end


    def adicionaRegistoRuido(leitura,timestamp,long,lat)
      rs = @con.query 'insert into registos (ruído, data,local_longitude,local_latitude) values ( ' +   
            leitura + ", '#{timestamp}'" + ', ' + long + ', ' + lat + ')'
    end
  end
