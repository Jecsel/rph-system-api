json.user_roles @user_roles.each do |role|
    json.name               role.name
end
json.user_types @user_types.each do |type|
    json.name               type.name
end
json.civil_statuses @civil_statuses.each do |stat|
    json.name               stat.name
end
json.genders @genders.each do |g|
    json.name               g.name
end
json.user_types @user_types.each do |type|
    json.id                 type.id
    json.name               type.name
end

json.user_roles @user_roles.each do |type|
    json.id                 type.id
    json.name               type.name
end

json.buildings @buildings.each do |type|
    json.id                 type.id
    json.name               type.name
end