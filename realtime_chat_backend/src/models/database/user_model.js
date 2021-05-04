const { Schema, model } = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const UserSchema = Schema({
    name: {
        type: String,
        required: [ true, 'Debes añadir un nombre.'],
    },
    email: {
        type: String,
        required: [ true, 'Debes añadir un email.'],
        unique: true,
    },
    hashedPassword: {
        type: String,
        required: [ true, 'Debes añadir una contraseña.'],
        required: true,
    },
    isOnline: {
        type: Boolean,
        default: false,
    },
});

// Add unique validation.
UserSchema.plugin(uniqueValidator, { message: 'Ya existe un usuario con el mismo campo "{PATH}".' });

UserSchema.method('toJSON', function() {
    const { __v, _id, password, ...object } = this.toObject();
    object.uid = _id;

    return object;
});

module.exports = model('User', UserSchema);