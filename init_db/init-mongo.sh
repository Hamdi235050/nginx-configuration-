mongo -- "evse" <<EOF
   db = db.getSiblingDB('admin');
   db.createUser(
   {
    user: 'evse-admin',
    pwd: 'evse-admin-pwd',
    roles: [
      'read',
      'readWrite',
      'dbAdmin',
      'userAdmin',
      'clusterAdmin',
      'readAnyDatabase',
      'readWriteAnyDatabase',
      'userAdminAnyDatabase',
      'dbAdminAnyDatabase'
    ],
    passwordDigestor: "server"
  }
);

db = db.getSiblingDB('evse');
db.createUser(
  {
    user: 'evse-user',
    pwd: 'evse-user-pwd',
    roles: [
      'readWrite'
    ],
    passwordDigestor: "server"
  }
);
db.getCollection('default.users').insert({
  _id: ObjectId(),
  email: 'super.admin@ev.com',
  address: {
    address1: null,
    address2: null,
    postalCode: null,
    city: null,
    department: null,
    region: null,
    country: null,
    coordinates: [
      0,
      0
    ]
  },
  costCenter: null,
  createdBy: null,
  createdOn: ISODate('2020-04-02T00:00:00.000+0000'),
  deleted: false,
  firstName: 'Super',
  iNumber: null,
  issuer: true,
  lastChangedBy: null,
  locale: 'en_US',
  mobile: null,
  name: 'ADMIN',
  notifications: {
    sendSessionStarted: true,
    sendOptimalChargeReached: true,
    sendEndOfCharge: true,
    sendEndOfSession: true,
    sendUserAccountStatusChanged: true,
    sendSessionNotStarted: true,
    sendCarSynchronizationFailed: true,
    sendUserAccountInactivity: true,
    sendPreparingSessionNotStarted: false,
    sendBillingSynchronizationFailed: false,
    sendNewRegisteredUser: false,
    sendUnknownUserBadged: false,
    sendChargingStationStatusError: false,
    sendChargingStationRegistered: false,
    sendOcpiPatchStatusError: false,
    sendOicpPatchStatusError: false,
    sendOfflineChargingStations: false
  },
  phone: null,
  password: '$2a$10$/c.TRisu3xPAGkgTL69b7uC4SGXqDIzFJuZgHOB1D.fvXf5h3WWwW',
  passwordBlockedUntil: null,
  passwordResetHash: null,
  passwordWrongNbrTrials: NumberInt(0),
  eulaAcceptedHash: '$2a$10$Qd3yjuNuTJL8tUsvcIdrEuYRw9.WeneMqrGYC/ldHG/MYNPVkmrg.',
  eulaAcceptedOn: ISODate('2020-04-02T00:00:00.000+0000'),
  eulaAcceptedVersion: 28,
  role: 'S',
  status: 'A',
  notificationsActive: true
});
EOF
