<?php
/**
 * User: fad
 * Date: 25.07.12
 * Time: 12:48
 */
class ChangePasswordForm extends CFormModel
{
    public $password;
    public $cPassword;

    public function rules()
    {
        return array(
            array('password, cPassword', 'required'),
            array(
                'password',
                'compare',
                'compareAttribute' => 'cPassword',
                'message'          => Yii::t('user', 'Passwords do not match!')
            )
        );
    }

    public function attributeLabels()
    {
        return array(
            'password'  => Yii::t('user', 'The new password'),
            'cPassword' => Yii::t('user', 'The new password again'),
        );
    }
}
