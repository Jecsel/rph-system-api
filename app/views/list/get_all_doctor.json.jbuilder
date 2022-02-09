json.doctors @doctors.each do |d|
    if d.has_profile
        json.id               d.id
        json.first_name             d.profile.first_name
        json.surname                d.profile.surname
    end
end