HELLO_ENCODED = {
  "encrypted_data"=>"R7PO9h304mw7XtTH/CntIg==\n",
  "encrypted_key"=>"m5Sbe8XxQvBR0enlXFugFSEOyQ3rmHvaFQaz4ePuV/TuADV1AOUdcb7D1peo\nseWsiXjlNUs/w2JA8eprkWUWJkjdeAtVCXlaarkNGajGOqCCiVUJpV//hDFS\nKNzn0uugTBTP+u7r3g5C/fbwZI3G3XZs91yDJlzAH80+jTCjSAiJvFB3mQIq\n7pPHMztjSSpjN2Y06hZvZJnjjCnRUbF71k0nUHLoxeErsBtiJ0l7u1A4M4Av\n3ewCr+/FgBLwLfT7vdNtF19kqnxsZdu7Q5JWubMXVyo7gbYspbKyVCbzxfD3\n9khwVkBY/A2D5KF6WliAniEXUTdUQMpn3iGjuR6wjg==\n",
  "fingerprint"=>"2500d0ed4d0ea1b3ea9f7f57a5f16c2fba8ad15d05d3c057d42f9796f1250169"
}

Fabricator(:notice) do
  question { Faker::Lorem.sentence }
  data { HELLO_ENCODED }
  user
  policy
end
