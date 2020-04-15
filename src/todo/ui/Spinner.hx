package todo.ui;

import pilot.Component;

class Spinner extends Component {

  override function render() return html(
    <div class={ css('
      position: absolute;
      border: 6px solid ${Color.secondary};
      border-radius: 50%;
      border-top: 6px solid ${Color.primary};
      width: 40px;
      height: 40px;
      margin-left: -20px;
      margin-top: -20px;
      left:50%;
      top:50%;
      animation: spin 2s linear infinite;
      
      @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
      }
    ') } />
  );

}

