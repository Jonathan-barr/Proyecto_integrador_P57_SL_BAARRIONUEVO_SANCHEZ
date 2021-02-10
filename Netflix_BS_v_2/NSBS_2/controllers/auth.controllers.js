const { response } = require('express');
const Usuario = require('../models/Usuario');
const bcrypt = require('bcryptjs');
const { generarJWT } = require('../helpers/jwt');
const { db } = require('../models/Usuario');



///  CREAR USUARIO
const crearUsuario = async(req, res = response) => {

    const { email, name, password } = req.body;


    try {

        // Verificar el email único
        const usuario = await Usuario.findOne({ email });

        if (usuario) {
            return res.status(400).json({
                ok: false,
                msg: 'El usuario ya existe con ese email'
            });
        }
        // Crear usuario con el modelo
        const dbUser = new Usuario(req.body);

        // Encriptar (Hashear) Contraseña
        //SALT = hace la encriptación en 10 vueltas por defecto
        const salt = bcrypt.genSaltSync();
        dbUser.password = bcrypt.hashSync(password, salt);

        // Generar el JWT (Json Web Token)
        const token = await generarJWT(dbUser.id, name);

        // Crear usuario de DB
        await dbUser.save();

        // Generar Respuesta Existosa
        return res.status(201).json({
            ok: true,
            uid: dbUser.id,
            name,
            email,
            token
        });

    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Por favor hable con el administrador'
        });

    }


}

// CONECTAR USUARIO
const loginUsuario = async(req, res = response) => {

    const { email, password } = req.body;

    try {

        const dbUser = await Usuario.findOne({ email });
        if (!dbUser) {
            return res.status(400).json({
                ok: false,
                msg: ' El correo o la Contraseña no son válidas, por favor intente de nuevo'
            });
        }

        // CONFIRMAR SI EL PWD hace MATCH   
        const validPassword = bcrypt.compareSync(password, dbUser.password);
        if (!validPassword) {
            return res.status(400).json({
                ok: false,
                msg: ' El correo o la Contraseña no son válidas, por favor intente de nuevo'
            });
        }
        // GENERAR el JWT
        // Generar el JWT (Json Web Token)
        const token = await generarJWT(dbUser.id, dbUser.name);

        // Respuesta del servicio

        return res.json({
            ok: true,
            uid: dbUser.id,
            name: dbUser.name,
            email: dbUser.email,
            token
        })

    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            msg: 'Hable con el Admnistrador'
        });

    }



}

// RENOVAR TOKEN
const renovarToken = async(req, res = response) => {

    const { uid } = req;

    // Leeer la base de datos
    const dbUser = await Usuario.findById(uid);

    // Generar el JWT (Json Web Token)
    const token = await generarJWT(uid, dbUser.name);

    return res.json({
        ok: true,
        uid,
        name: dbUser.name,
        email: dbUser.email,
        token
    });
}

/// EXPORTAR 
module.exports = {
    crearUsuario,
    loginUsuario,
    renovarToken
}