class Hello_Sayer
  def sayHello(name)
    "Hello, #{name}"
    puts "blah"
    puts "foo"
  end
  
  def get_not_so_magic_fixnum
    1
  end
  
  def get_magic_fixnum
    5
  end
  
  def get_magic_bignum
    123456789012345678901234567890
  end
end

sayer = Hello_Sayer.new
puts sayer.sayHello('marty')


