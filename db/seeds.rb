UserRole.create([{name:'guest'},{name: 'member'},{name:'admin'},{name:'super_admin'}])
UserType.create([{name:'patient'},{name:'nurse'},{name:'doctor'},{name:'administrator'}])
Gender.create([{name:'male'},{name: 'female'}])
CivilStatus.create([{name: 'single'},{name: 'married'}])
Building.create([{name: 'building 1'}, {name: 'building 2'}])
LocalService.create([{name: 'c1'},{name: 'c2'},{name: 'c3'}])
Result.create([{name: 'recovered'},{name:'improved'},{name: 'unimproved'}, {name: 'died'}])
Disposition.create([{name: 'discharged at'},{name: 'length of stay'},{name: 'absconded'},{name: 'dismissed'}, {name: 'transferred to'}])
ClinicService.create([
    {name: 'charity'},
    {name: 'resident'},
    {name: 'transient'},
    {name: 'government'},
    {name: 'private pay'}
])
Clinic.create([
    {name: 'medical'},
    {name: 'pediatrics'},
    {name: 'surgery'},
    {name: 'gynecology'},
    {name: 'e.e.n.t'},
    {name: 'urology'},
    {name: 'dermatology'},
    {name: 'neurology'},
    {name: 'obstetrics'},
    {name: 'dental'}
])
Department.create([
    {name: 'medical'},
    {name: 'surgical'},
    {name: 'obstetrics'},
    {name: 'pediatrics'},
    {name: 'nicu'},{name: 'gyne'},
    {name: 'optha'},{name: 'ent'}
])
SocietyClass.create([
    {name: 'private'},
    {name: 'charity'},
    {name: 'life/senior'},
    {name: 'non philhealth'},
    {name: 'philhealth'},
    {name: 'ofw'},
    {name: 'gm'},
    {name: 'gd'},
    {name: 'sem'},
    {name: 'pem'},
    {name: 'im'},
    {name: 'id'},
    {name: 'sed'},
    {name: 'ped'}
])

User.create(username: 'rph', password: '123123123', user_role_id: 4, user_type_id: 4, is_active: true)
User.create(username: 'patient', password: '123123123', user_role_id: 1, user_type_id: 1, is_active: true)
User.create(username: 'nurse', password: '123123123', user_role_id: 2, user_type_id: 2, is_active: true)
User.create(username: 'doctor', password: '123123123', user_role_id: 3, user_type_id: 3, is_active: true)