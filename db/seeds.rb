# db/seeds.rb

# Solo ejecuta destroy_all si es desarrollo o está permitido
if Rails.env.development? || ENV['ALLOW_SEED_DESTROY'] == 'true'
  User.destroy_all
else
  puts "⚠️  User.destroy_all no se ejecutó (solo permitido en desarrollo)"
end

# Ejecutar solo si no se especificó SEED_MODULE o es 'users'
if ENV['SEED_MODULE'].nil? || ENV['SEED_MODULE'] == 'users'
  begin
    # Admin principal
    admin1 = User.find_or_create_by!(email: 'admin@school.com') do |u|
      u.password = 'password123'
      u.password_confirmation = 'password123'
      u.role = :admin
    end
    puts "✅ Admin principal: #{admin1.email} (ID: #{admin1.id})"

    # Admin Zahira (con manejo de mayúsculas/minúsculas en email)
    admin2 = User.find_or_initialize_by(email: 'Zahiragarcia@icloud.com'.downcase)
    if admin2.persisted?
      admin2.update!(
        password: 'zahialianza12',
        password_confirmation: 'zahialianza12',
        role: :admin
      )
      puts "✅ Admin Zahira actualizado"
    else
      admin2.update!(
        email: 'Zahiragarcia@icloud.com'.downcase,
        password: 'zahialianza12',
        password_confirmation: 'zahialianza12',
        role: :admin
      )
      puts "✅ Admin Zahira creado"
    end

    # Usuario normal
    user = User.find_or_create_by!(email: 'user@school.com') do |u|
      u.password = 'password123'
      u.password_confirmation = 'password123'
      u.role = :user
    end
    puts "✅ User: #{user.email}"

  rescue => e
    puts "❌ Error crítico: #{e.message}"
    raise e
  end
end

# Otras partes del seed pueden ir aquí con condiciones similares
# if ENV['SEED_MODULE'].nil? || ENV['SEED_MODULE'] == 'otra_parte'