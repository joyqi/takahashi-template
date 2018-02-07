<?php
$files = glob('./page/*.html');
?>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
        <title>Joyqi 的PPT</title>
    </head>
    <body>
        <h1>JoyQi的PPT存档</h1>
        <hr>
        <ul>
        <?php foreach ($files as $file): ?>
            <li><a href="<?php echo $file; ?>"><?php echo basename($file); ?></a></li>
        <?php endforeach; ?>
        </ul>
    </body>
</html>
