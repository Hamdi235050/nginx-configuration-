mongo admin --host ev_mongo -u evse-admin -p evse-admin-pwd <<EOF
rs.initiate(
  {
   _id: 'rs0',
    version: 1,
    members: [
      {
        _id: 0,
        host: 'ev_mongo:27017'
      }
    ]
}
)
EOF