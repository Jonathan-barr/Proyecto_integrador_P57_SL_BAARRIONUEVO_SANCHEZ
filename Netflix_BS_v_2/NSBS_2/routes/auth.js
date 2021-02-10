const { Router } = require('express');
const { check } = require('express-validator');
const { crearUsuario, loginUsuario, renovarToken } = require('../controllers/auth.controllers');
const { validarCampos } = require('../middlewares/validar-campos');
const { validarJWT } = require('../middlewares/validar-jwt');


const router = Router();

// Petición Crear un Usuario
router.post('/new', [

    check('name', ' El nombre es obligatorio').not().isEmpty(),
    check('email', ' El email es obligatorio').isEmail(),
    check('password', ' la contraseña es obligatoria').isLength({ min: 6 }),
    validarCampos
], crearUsuario);

// Petición login un Usuario
router.post('/', [
    check('email', ' El email es obligatorio').isEmail(),
    check('password', ' la contraseña es obligatoria').isLength({ min: 6 }),
    validarCampos
], loginUsuario);
// Validar un token
router.get('/renew', validarJWT, renovarToken);


module.exports = router;