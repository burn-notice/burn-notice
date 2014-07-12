HELLO_ENCODED = {
  :encrypted_data=>"3atDpYVoESI3PrNoe0bovg==\n",
  :encrypted_key=>"j0xROOxeEE99W6mneWWU8OABmsPRuawMUQ9C3+g5GRB9K3A49SGSoM8GTpUT\n72XoQzWue7GwYtI0OTjShQhl8HCM7fhz63QQIwIgDBIE1J6pd9poqlEnRyGX\ncx/NMcpYxCAlC0H8t8KF4SEyMpcaZnReI2QGbYx2vqaGtiMxqH/18hsmTa7F\nuCizYrLQBGsNXiCbXCb61aCCTQTgdv7pJVRuVHcfFO5R6Lo4mNocai+dlKvV\nw/rqhyg7kD0i1AVbFX9C9krhtIjg7wZKE0d2N2+47q9IA8BguNWBEvRW/Lmz\n/9EkT4X7rk/bYr1N1Fk6hoJn6ZQAe802ZUh9Myq9MA==\n",
  :fingerprint=>"a7adb0ae534f69c77c1bc184b37c4480f5994bf75f5e449695d3e4e13c86209f"
}

Fabricator(:notice) do
  data { HELLO_ENCODED }
  user
  policy
end
