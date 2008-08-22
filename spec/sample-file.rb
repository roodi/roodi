class Hello_Sayer
  def sayHello(name)
    "Hello, #{name}"
    puts "blah"
    puts "foo"
  end
end

sayer = Hello_Sayer.new
puts sayer.sayHello('marty')


