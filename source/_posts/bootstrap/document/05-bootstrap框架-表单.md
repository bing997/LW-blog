---
title: 05-bootstrap框架-表单
date: 2024-08-16T14:04:39+08:00
tags:
    - bootstrap
    - 教程
categories: bootstrap
cover:  https://bing997.github.io/LW-blog/images/cover05.png
index_enable: true # 是否显示文章封面
aside_enable: true 
archives_enable: true 
position: both  # 封面显示的位置 三个值可配置left , right , both 
default_cover:   # 当没有设置cover时，默认的封面显示
sticky: false  # 设置为 true 即可置顶
description: "bootstrap"
---

## 表单

### 基础表单
Bootstrap 提供了基础表单样式，通过简单的 HTML 标签和 Bootstrap 样式类可以快速创建一个基本表单。

#### 基本实例
```html
<form>
  <div class="form-group">
    <label for="exampleInputEmail1">Email address</label>
    <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter email">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1">Password</label>
    <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
  </div>
  <button type="submit" class="btn btn-primary">Submit</button>
</form>
```
>`form-group`: 包裹表单元素，提供垂直间距。
`form-control`: 应用于输入框，使其具有 Bootstrap 样式。


#### 内联表单
内联表单将表单元素在一行内显示，适合用于简单的表单。

```html
<form class="form-inline">
  <div class="form-group">
    <label for="exampleInputName2">Name</label>
    <input type="text" class="form-control" id="exampleInputName2" placeholder="Jane Doe">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail2">Email</label>
    <input type="email" class="form-control" id="exampleInputEmail2" placeholder="jane.doe@example.com">
  </div>
  <button type="submit" class="btn btn-primary">Send invitation</button>
</form>
```
>`form-inline`: 使表单元素内联显示。

#### 水平表单
水平表单使用网格系统对表单进行布局，使标签和输入框并排显示。

```html
<form class="form-horizontal">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">Email</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputEmail3" placeholder="Email">
    </div>
  </div>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">Password</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="inputPassword3" placeholder="Password">
    </div>
  </div>
  <button type="submit" class="btn btn-default">Sign in</button>
</form>
```
> `form-horizontal`: 使表单水平布局。
`control-label`: 标签与输入框对齐。

### 输入框
使用 `form-control` 类可以为各种输入框（如文本框、密码框等）提供一致的样式。

```htnl
<input type="text" class="form-control" placeholder="Text input">
```

### 下拉框
`form-control` 类同样适用于下拉框，保证其与其他表单元素的样式一致。

```html
<select class="form-control">
  <option>Option 1</option>
  <option>Option 2</option>
  <option>Option 3</option>
</select>
```

### 文本域
文本域用于多行文本输入，使用 `form-control` 来保持样式统一。

```html
<textarea class="form-control" rows="3"></textarea>
```

### 复选框和单选按钮
Bootstrap 提供了对复选框和单选按钮的样式支持，使其与表单的整体样式一致。

```html
<div class="checkbox">
  <label>
    <input type="checkbox"> Check me out
  </label>
</div>

<div class="radio">
  <label>
    <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked>
    Option one is this and that—be sure to include why it's great
  </label>
</div>
```

### 表单焦点
可以通过 `has-success`、`has-warning` 和 `has-error` 类来为表单元素添加不同的状态样式，用于提示用户输入的正确性。

```html
<div class="form-group has-success">
  <input type="text" class="form-control" id="inputSuccess1">
</div>
```

### 表单禁用
通过在表单控件上添加 `disabled` 属性来禁用表单元素，使其不可交互。

```html
<input type="text" class="form-control" placeholder="Disabled input here..." disabled>
```

### 验证样式

#### 颜色提示
使用 `has-success`、`has-warning` 和 `has-error` 类来为表单元素添加颜色提示，用于表示不同的验证状态。

```html
<div class="form-group has-error">
  <label class="control-label" for="inputError">Input with error</label>
  <input type="text" class="form-control" id="inputError">
</div>
```

#### 图标提示
通过添加 `form-control-feedback` 类可以在表单元素旁添加图标，用于进一步提示输入状态。

```html
<div class="form-group has-success has-feedback">
  <label class="control-label" for="inputSuccess2">Input with success</label>
  <input type="text" class="form-control" id="inputSuccess2">
  <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true"></span>
</div>
```

#### 文字提示
通过在表单元素后添加帮助文本（`help-block` 类），可以给用户提供额外的输入提示。

```html
<div class="form-group">
  <label class="control-label" for="inputWarning">Input with warning</label>
  <input type="text" class="form-control" id="inputWarning">
  <span class="help-block">This is a warning message.</span>
</div>
```

### 元素大小

#### 高度

通过添加 `input-lg` 或 `input-sm` 类来调整输入框的高度。

```html
<input class="form-control input-lg" type="text" placeholder=".input-lg">
<input class="form-control input-sm" type="text" placeholder=".input-sm">
```

#### 宽度
使用 Bootstrap 网格系统可以调整表单元素的宽度。

```html
<div class="col-xs-4">
  <input type="text" class="form-control" placeholder=".col-xs-4">
</div>
<div class="col-xs-8">
  <input type="text" class="form-control" placeholder=".col-xs-8">
</div>
```

### 输入框组
输入框组允许将多个输入框或按钮组合在一起，通常用于带有前缀或后缀的输入框。

```html
<div class="input-group">
  <span class="input-group-addon">$</span>
  <input type="text" class="form-control" placeholder="Amount">
  <span class="input-group-addon">.00</span>
</div>
```

### 案例：一个表单页面
```html
<!DOCTYPE html>
<html lang="zh">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1">
		<title>Document</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
			integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
	</head>
	<body>
		<div class="container">
			<h3 class="text-center">Contact</h3>
			<p class="text-center"><em>We love our fans!</em></p>

			<div class="row test">
				<div class="col-md-4">
					<p>Fan?Drop a note.</p>
					<p><span class="glyphicon glyphicon-map-marker"></span>Chicago,US</p>
					<p><span class="glyphicon glyphicon-phone"></span>Phone:+00 15151
						51515</p>
					<p><span class="glyphicon glyphicon-envelope"></span>Email:mail@mail.
						com</p>
				</div>

				<div class="col-md-8">
					<div class="row">
						<div class="col-sm-6 form-group">
							<input class="form-control" id="name" name="name" placeholder="Name" type="text" required>
						</div>
						<div class="col-sm-6 form-group">
							<input class="form-control" id="email" name="email" placeholder="Email" type="email"
								required>
						</div>
					</div>
					<textarea class="form-control" id="comments" name="comments" placeholder="Comment"
						rows="5"></textarea>
					<div class="row">
						<div class="col-md-12 form-group">
							<button class="btn pull-right" type="submit">Send</button>
						</div>
					</div>
				</div>
			</div>

		</div>

	</body>
</html>
```

### 案例：百度的注册页面
```html
<!DOCTYPE html>
<html lang="zh-CN">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>百度注册</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
		<style>
			body {
				background-color: #f8f8f8;
			}

			.register-container {
				max-width: 400px;
				margin: 50px auto;
				padding: 20px;
				background-color: #fff;
				border-radius: 4px;
				box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			}

			.register-header {
				text-align: center;
				margin-bottom: 20px;
			}

			.btn-register {
				width: 100%;
			}

			.third-party-login {
				text-align: center;
				margin-top: 20px;
			}
		</style>
	</head>
	<body>

		<div class="register-container">
			<h2 class="register-header">百度用户注册</h2>
			<form>
				<div class="form-group">
					<label for="phoneNumber">手机号码</label>
					<input type="text" class="form-control" id="phoneNumber" placeholder="请输入手机号码">
				</div>
				<div class="form-group">
					<label for="verifyCode">验证码</label>
					<div class="input-group">
						<input type="text" class="form-control" id="verifyCode" placeholder="请输入验证码">
						<span class="input-group-btn">
							<button class="btn btn-default" type="button">获取验证码</button>
						</span>
					</div>
				</div>
				<div class="form-group">
					<label for="password">设置密码</label>
					<input type="password" class="form-control" id="password" placeholder="请输入密码">
				</div>
				<div class="form-group">
					<div class="checkbox">
						<label>
							<input type="checkbox"> 我已阅读并同意 <a href="#">《服务协议》</a>
						</label>
					</div>
				</div>
				<button type="submit" class="btn btn-primary btn-register">立即注册</button>
			</form>

			<div class="third-party-login">
				<p>其他登录方式：</p>
				<button type="button" class="btn btn-success">使用微信登录</button>
				<button type="button" class="btn btn-info">使用QQ登录</button>
			</div>
		</div>

		<script src="https://cdn.jsdelivr.net/npm/jquery@3.3.1/dist/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js"></script>
	</body>
</html>
```


