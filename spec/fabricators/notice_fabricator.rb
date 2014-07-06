HELLO_ENCODED = {
  "encrypted_data"=>"i+c+cGsLy7tVfdidkQ+QdQ==\n",
 "encrypted_key"=> "ScXMUZaqFqWl711wxkIUzpXs5xjekevu5sU7upBq6yhmU4FhZ4AncVP9AA3F\nkIYFEyf+ZQ4n+PFQgZ8f/s1M03nSO1vGJui9DowDSyqIGjLTpm5XDyNY7B69\noLVbkjdLIYEpVTDPD5mZxT/aWer5ERf+WnwnAxtw9NZtcd8636ncj0mWa82w\nl24Cnm7n91PTreCAG8MTjR0ed0571wHDsikDTb/vWMAA/9YayB0mHianxUGg\npowbFZyzDvOApjUNFEBCbHAlcIk/AImrae8o+mkeopyWL2i1O4W7r2kmsmKj\nuWp4ZccvjR56ajuZu4MYJhtFRJdAObpqPt9hI0H8pw==\n"
}

Fabricator(:notice) do
  data { HELLO_ENCODED }
  user
  policy
end
