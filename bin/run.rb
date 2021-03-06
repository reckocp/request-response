require_relative '../db/setup'
# Remember to put the requires here for all the classes you write and want to use

def parse_params(uri_fragments, query_param_string)
  params = {}
  params[:resource]  = uri_fragments[3]
  params[:id]        = uri_fragments[4]
  params[:action]    = uri_fragments[5]
  if query_param_string
    param_pairs = query_param_string.split('&')
    param_k_v   = param_pairs.map { |param_pair| param_pair.split('=') }
    param_k_v.each do |k, v|
      params.store(k.to_sym, v)
    end
  end
  params
end
# You shouldn't need to touch anything in these methods.
def parse(raw_request)
  pieces = raw_request.split(' ')
  method = pieces[0]
  uri    = pieces[1]
  http_v = pieces[2]
  route, query_param_string = uri.split('?')
  uri_fragments = route.split('/')
  protocol = uri_fragments[0][0..-2]
  full_url = uri_fragments[2]
  subdomain, domain_name, tld = full_url.split('.')
  params = parse_params(uri_fragments, query_param_string)
  return {
    method: method,
    uri: uri,
    http_version: http_v,
    protocol: protocol,
    subdomain: subdomain,
    domain_name: domain_name,
    tld: tld,
    full_url: full_url,
    params: params
  }
end

USERS = [
  {:first => "Colin", :last => "Recko", :age => 27},
  {:first => "Sarah", :last => "Huey", :age => 28},
  {:first => "Justin", :last => "Herrick", :age => 2},
  {:first => "Steven", :last => "Ralph", :age => 28},
  {:first => "Elizer", :last => "Rios", :age => 27},
  {:first => "Barack", :last => "Obama", :age => 54},
  {:first => "Beyonce", :last => "Knowles", :age => 34},
  {:first => "Brian", :last => "Bemben", :age => 32},
  {:first => "Conor", :last => "Recko", :age => 23},
  {:first=> "Aileen", :last => "Wall", :age => 93}
]

system('clear')
loop do
  print "Supply a valid HTTP Request URL (h for help, q to quit) > "
  raw_request = gets.chomp

  case raw_request
  when 'q' then puts "Goodbye!"; exit
  when 'h'
    puts "A valid HTTP Request looks like:"
    puts "\t'GET http://localhost:3000/students HTTP/1.1'"
    puts "Read more at : http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html"
  else
    @request = parse(raw_request)
    @params  = @request[:params]
    if @request[:method] == "GET" &&
        @params[:resource] == "users" &&
        (@params[:id].to_i-1) > USERS.length
        puts "HTTP 404 File Not Found"
        puts "That's not a valid request."
    elsif @request[:method] == "GET" &&
      @params[:resource] == "users" &&
      (@params[:id].to_i-1) >= 0

      id = @params[:id].to_i-1

      puts "HTTP/1.1 200 OK"
      puts
      puts USERS[id].values.join(' ')

    elsif @request[:method] == "GET" && @params[:resource] == "users"
      puts "HTTP/1.1 200 OK"
      puts
      USERS.each do |user|
        user.each do |_,value|
          print "#{value} "
        end
        print "\n"
      end
    else
      puts "ERROR! That's not right."
    end
  end
end
