// all strings used in API
class ApiConstant {
  static const String baseUrl = 'https://api.gosorsolutions.com/public/api/';
  static const String login = 'login';
  static const String logout = 'logout';
  static const String register = 'register';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String passwordConfirmation = 'password_confirmation';
  static const String tasks = 'tasks';
  static const String deliveryDate = 'delivery_date';
  static const String start = 'start';
  static const String end = 'end';
  static const String priority = 'priority';
  static const String status = 'status';
  static const String title = 'title';
  static const String description = 'description';
  static const String accept = 'Accept';
  static const String acceptValue = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}

// All strings used as key to store data locally
class DataBaseKeys {
  static const String userName = 'user_name';
  static const String token = 'token';
  static const String userEmail = 'user_Email';
  static const String tasksBox = 'tasksBox';
}

class HomeCubitStrings {
  // different task status
  static const String inProgress = 'in_progress';
  static const String pending = 'pending';
  static const String completed = 'completed';
  static const String outDated = 'out_dated';
}

// all strings used in UI
class AppStrings {
  static const String appName = 'Task App';
  static const String login = 'Login';
  static const String loginSubtitle = 'Login to your account';
  static const String email = 'Email';
  static const String emailHint = 'example@email.com';
  static const String password = 'Password';
  static const String passwordHint = 'password';
  static const String dontHaveAccount = 'Don’t have an account?';
  static const String createAccount = 'Create account';
  static const String signupSubtitle = 'Create a new account for free';
  static const String name = 'Name';
  static const String nameHint = 'Mohamed Halim';
  static const String register = 'Register';
  static const String haveAccount = 'Already have an account?';
  static const String enterNewName = 'Please enter new name or email';
  static const String enterNewEmail = 'Please enter new email or name';
  static const String userDataUpdatedSuccessfully =
      'User data updated successfully';
  static const String userCreated =
      'User created successfully, Now you can login';
  static const String ok = 'OK';
  static const String error = 'Error';
  static const String fillField = 'You need to fill this field';
  static const String validName = 'Enter valid name';
  static const String validEmail = 'Enter valid email address';
  static const String validPassword =
      'The password field must be at least 8 characters';
  static const String home = 'Home';
  static const String addTask = 'Add Task';
  static const String profile = 'Profile';
  static const String hello = 'Hello 👋';
  static const String userName = 'Mohamed Halim';
  static const String task = 'Task';
  static const String newTasks = 'New Tasks';
  static const String newTask = 'New Task';
  static const String completed = 'Completed';
  static const String inProgress = 'In Progress';
  static const String outDated = 'Out Dated';
  static const String recentTasks = 'Recent Tasks';
  static const String filter = 'Filter';
  static const String changeStatus = 'Change Status';
  static const String changeTaskStatus = 'Change Task Status';
  static const String taskStatusChangedSuccessfully =
      'Task Status Changed Successfully';
  static const String createNewTask = 'Create New Task';
  static const String taskName = 'Task Name';
  static const String taskNameHint = 'task name';
  static const String note = 'Note';
  static const String noteHint = 'note';
  static const String createTask = 'Create Task';
  static const String date = 'Date';
  static const String sun = 'SUN';
  static const String mon = 'MON';
  static const String tue = 'TUE';
  static const String wed = 'WED';
  static const String thu = 'THU';
  static const String fri = 'FRI';
  static const String sat = 'SAT';
  static const String taskCreatedSuccessfully = 'Task Created Successfully';
  static const String logout = 'Logout';
  static const String update = 'Update';
  static const String low = 'Low';
  static const String inProgressTasks = 'In Progress Tasks';
  static const String completedTasks = 'Completed Tasks';
  static const String outDatedTasks = 'Out Dated Tasks';
  static const String today = 'Today';
  static const String tomorrow = 'Tomorrow';
  static const String in_ = 'In';
  static const String days = 'days';
  static const String months = 'months';
  static const String month = 'month';
  static const String years = 'years';
  static const String year = 'year';
  static const String noTasksHere = 'No Tasks Here Yet';
  static const String select = 'Select';
  static const String taskUpdatedSuccessfully = 'Task Updated Successfully';
  static const String selectNewDate = 'Select New Date';
  static const String youCantChangeOutDatedTask =
      'You Can\'t Change Out Dated Task';
  static const String youCantChangeTaskToBeOutDated =
      'You Can\'t Change Task To Be Out Dated';
  static const String thisTaskAlreadyExists = 'This Task Already Exists';
  static const String noInternetAndLocalDatabaseCorrupted =
      "Your internet connection is lost, and local database is corrupted, please login again";
}
