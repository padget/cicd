function job() 
{
  for arg in $* ; do
    echo "i" $arg
  done
}