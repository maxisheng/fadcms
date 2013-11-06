<?php

class PostController extends Controller
{
    /**
     * @return array a list of filter configurations.
     */
    public function filters()
    {
        return array(
            'postOnly + delete',/** @see CController::filterPostOnly */
            array('auth.filters.AuthFilter - show')/** @see AuthFilter */
        );
    }

    /**
     * Show the post
     * @param string $slug
     * @throws CHttpException 404 if not found
     */
    public function actionShow($slug)
    {
        /** @var $model Post */
        if (Yii::app()->user->isGuest) {
            $model = Post::model()->published()->public()->find('slug = :slug', array(':slug' => $slug));
        } else {
            $model = Post::model()->published()->find('slug = :slug', array(':slug' => $slug));
        }

        if (!$model) {
            throw new CHttpException(404, Yii::t('BlogModule.blog', 'Post not found!'));
        }
        //$this->httpCacheFilter($model->update_time); comments!!
        $model->publish_time = Yii::app()->dateFormatter->formatDateTime($model->publish_time, 'short', 'short');
        $model->content      = str_replace('<cut>', '<a name="cut"></a>', $model->content);
        $this->setMetaTags($model);
        $this->render('show', array('model' => $model, 'tags' => $model->getTags()));
    }

    public function actionTag($tag)
    {
        $tag               = CHtml::encode($tag);
        $postsDataProvider = new CActiveDataProvider(Post::model()->published()->public()->taggedWith($tag), array(
            'sort' => array(
                'defaultOrder' => 'publish_time DESC',
            )
        ));
        $this->render(
            'blog.views.default.show',
            array(
                'postsDataProvider' => $postsDataProvider,
                'tag'               => $tag,
            )
        );
    }

    /**
     * Displays a particular model.
     * @param integer $id the ID of the model to be displayed
     */
    public function actionView($id)
    {
        $this->render('view', array('model' => $this->loadModel($id)));
    }

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
    public function actionCreate()
    {
        $model = new Post;

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['Post'])) {
            $model->attributes = $_POST['Post'];
            $model->setTags(Yii::app()->getRequest()->getPost('tags'));
            if ($model->save()) {
                $this->redirect(array('view', 'id' => $model->id));
            }
        }

        $this->render('create', array('model' => $model));
    }

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate($id)
    {
        $model = $this->loadModel($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['Post'])) {
            $model->attributes = $_POST['Post'];
            $model->setTags(Yii::app()->getRequest()->getPost('tags'));
            if ($model->save()) {
                $this->redirect(array('view', 'id' => $model->id));
            }
        }

        $this->render('update', array('model' => $model));
    }

    /**
     * Deletes a particular model.
     * We only allow deletion via POST request @see CController::filterPostOnly
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param int $id the ID of the model to be deleted
     * @throws CHttpException 400 if not not POST request
     */
    public function actionDelete($id)
    {
        $this->loadModel($id)->delete();
        // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
        if (!isset($_GET['ajax'])) {
            $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
        }
    }

    /**
     * Lists all models.
     */
    public function actionIndex()
    {
        $dataProvider = new CActiveDataProvider('Post');
        $this->render('index', array('dataProvider' => $dataProvider));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin()
    {
        $model = new Post('search');
        $model->unsetAttributes(); // clear any default values
        if (isset($_GET['Post'])) {
            $model->attributes = $_GET['Post'];
        }

        $this->render('admin', array('model' => $model));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param int $id the ID of the model to be loaded
     * @throws CHttpException 404 if not found
     * @return Post
     */
    public function loadModel($id)
    {
        $model = Post::model()->findByPk($id);
        if ($model === null) {
            throw new CHttpException(404, 'The requested page does not exist.');
        }
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param CModel $model the model to be validated
     */
    protected function performAjaxValidation($model)
    {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'post-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }
}
