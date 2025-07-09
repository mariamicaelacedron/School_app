# db/seeds.rb

# Limpiar datos existentes (solo en desarrollo)
User.destroy_all

# Crear usuarios usando create! para ver errores inmediatos
begin
  admin = User.create!(
    email: 'admin@school.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: :admin
  )
  puts "✅ Admin creado: #{admin.email}"

  user = User.create!(
    email: 'user@school.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: :user
  )
  puts "✅ User creado: #{user.email}"
rescue => e
  puts "❌ Error creando usuarios: #{e.message}"
end