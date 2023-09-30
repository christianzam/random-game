import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
static targets = ['btnCreate']

  connect() {
    console.log('contected');
  }

  displayTournament(event){
    event.preventDefault();
    
    Rails.ajax({
      type: 'post',
      url: event.target.action,
      data: new FormData(event.target),
      success: () => {
        // Turbo.visit(window.location.pathname, { target: 'tournament-index' });
        window.location.reload();
      },
      error: () => {
        console.error('error');
      }
    });
  }
}
