 $image=$args[0]
if($image -eq "C") {
   echo "Building client image.."
   docker build -t nordic/client --file ./client/Dockerfile --target clientimg .
}
elseif($image -eq "S"){
   echo "Building server image.."
   docker build -t nordic/server --file ./server/web/Dockerfile --target serverimg .
}
elseif ($image -eq "B") {
   echo "Building client and server image.."
   docker build -t nordic/client --file ./client/Dockerfile --target clientimg .
   docker build -t nordic/server --file ./server/web/Dockerfile --target serverimg .
}