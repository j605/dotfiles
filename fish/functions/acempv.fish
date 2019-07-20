function acempv
  acestream-launcher $argv[1] \
  -p "mpv --profile=low-latency --dscale=bilinear --deband=no $argv[2]"
end

