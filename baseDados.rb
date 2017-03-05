  require 'mysql'

  class BaseDados

    def initialize(hostname,username,password,databasename)
        @con = Mysql.new(hostname, username,password, databasename)  
    end

    def close
        @con.close
    end

    def verificaClienteExiste(long,lat)
      
        rs = @con.query 'SELECT * from local where longitude=' + long + 
          ' and latitude=' + lat
        n_rows = rs.num_rows # Por alguma razao aqui da sempre 0 ... 
        puts n_rows
        if(n_rows==0) 
          rs = @con.query 'insert into local values ( ' + long  + ', ' + lat + ')' 
        end
    end

    def adicionaRegisto
      
    end
  end
