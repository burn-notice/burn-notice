MOIN_ENCODED = {
  "encrypted_data"=>"WhT7q2rZhGVy+iVjW/5Zxw==\n",
  "encrypted_key"=>"S3vXXmqetn8Uaz7Qjbhw3Qmwd7SctpuQUpS7RXtmAQu6vEdl4Um+oPTa044j\nubKvorDt8EQRqiGY1JU37FZdl0HQ3eCFQimXbAAKYYQu9itZsO5uPye5kJ6q\nIe/QlsVYlw/ET5g2WAvcG6Z6izviE54PZI7PU/Of1MT6odFKsAdKKHG9PPiL\nx4F3UQKeSX7pQgZwt6JVfQCDIBDin9hkpU/XElwD8f9D6lIYDlBrVfMWPIzF\nOx8TLVV0c0Q4pl87tRKTeLv36VCd6oPABd6oZK748Mw5FeBRyyu4I6ljoxak\nOV7TW6EdjlSA4Y8RBDcq0TFp0hxclr332SBikGSkDg==\n",
  "fingerprint"=>"2500d0ed4d0ea1b3ea9f7f57a5f16c2fba8ad15d05d3c057d42f9796f1250169",
  "version"=>1,
}

MOIN_ENCODED_LEGACY = {
  "encrypted_data"=>"R7PO9h304mw7XtTH/CntIg==\n",
  "encrypted_key"=>"m5Sbe8XxQvBR0enlXFugFSEOyQ3rmHvaFQaz4ePuV/TuADV1AOUdcb7D1peo\nseWsiXjlNUs/w2JA8eprkWUWJkjdeAtVCXlaarkNGajGOqCCiVUJpV//hDFS\nKNzn0uugTBTP+u7r3g5C/fbwZI3G3XZs91yDJlzAH80+jTCjSAiJvFB3mQIq\n7pPHMztjSSpjN2Y06hZvZJnjjCnRUbF71k0nUHLoxeErsBtiJ0l7u1A4M4Av\n3ewCr+/FgBLwLfT7vdNtF19kqnxsZdu7Q5JWubMXVyo7gbYspbKyVCbzxfD3\n9khwVkBY/A2D5KF6WliAniEXUTdUQMpn3iGjuR6wjg==\n",
  "fingerprint"=>"2500d0ed4d0ea1b3ea9f7f57a5f16c2fba8ad15d05d3c057d42f9796f1250169",
}

Fabricator(:notice) do
  question { Faker::Lorem.sentence }
  data { MOIN_ENCODED }
  user
  policy
end

Fabricator(:legacy_notice, from: :notice) do
  data { MOIN_ENCODED_LEGACY }
end

Fabricator(:notice_with_opening, from: :notice) do
  data { MOIN_ENCODED_LEGACY }
  openings(count: 1)
end
