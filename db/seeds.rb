# db/seeds.rb

# Evita borrar datos en producción por seguridad
if Rails.env.development? || ENV['ALLOW_SEED_DESTROY'] == 'true'
  User.destroy_all
else
  puts "⚠️  User.destroy_all no se ejecutó (solo permitido en desarrollo)"
end

begin
  # Busca o crea el admin principal para evitar duplicados
  admin1 = User.find_or_create_by!(email: 'admin@school.com') do |u|
    u.password = 'password123'
    u.password_confirmation = 'password123'
    u.role = :admin
  end
  puts "✅ Admin principal: #{admin1.email} (ID: #{admin1.id})"

  # Busca o crea el segundo admin (Zahira)
  admin2 = User.find_or_create_by!(email: 'Zahiragarcia@icloud.com') do |u|
    u.password = 'zahialianza12'
    u.password_confirmation = 'zahialianza12'
    u.role = :admin
  end
  puts "✅ Admin secundario: #{admin2.email} (ID: #{admin2.id})"

  # Actualiza grades huérfanas para que apunten al admin principal
  Grade.where(admin_id: nil).update_all(admin_id: admin1.id) if defined?(Grade)

  # Usuario normal
  user = User.find_or_create_by!(email: 'user@school.com') do |u|
    u.password = 'password123'
    u.password_confirmation = 'password123'
    u.role = :user
  end
  puts "✅ User: #{user.email}"

rescue => e
  puts "❌ Error crítico: #{e.message}"
  raise e # Detiene la ejecución para que notes el error
end