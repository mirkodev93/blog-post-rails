class AddUserToBlogs < ActiveRecord::Migration[8.0]
  def up
    add_reference :blogs, :user, null: true, foreign_key: true

    user = User.first || User.create!(
      email: "system@example.com",
      password: SecureRandom.hex(16),
      password_confirmation: nil
    )

    Blog.where(user_id: nil).update_all(user_id: user.id)

    change_column_null :blogs, :user_id, false
  end

  def down
    remove_reference :blogs, :user, foreign_key: true
  end
end
