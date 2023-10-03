import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = ['playersTable', 'shuffleBtn']

  connect() {
    console.log('connected');
    console.log(this.shuffleBtnTarget);
  }

  displayDraw(event) {
    event.preventDefault();

    Rails.ajax({
      type: 'post',
      url: event.target.action,
      data: new FormData(event.target),
      success: () => {
        console.log('success');
        // console.log();
        // this.insertUsersToTable();
      },
      error: () => {
        console.error('error');
        console.error();
      }
    });
  }

  insertUsersToTable() {
    console.log('click')
  }
}
