import { LoginDTO } from '../dtos/user/login.dto';
import { Router } from '@angular/router';
import { UserService } from '../services/user.service';
import { NgForm } from '@angular/forms';
import { Component, ViewChild } from '@angular/core';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {

  @ViewChild('loginForm') loginForm!: NgForm;

  constructor(private router: Router, private userService: UserService) {

  }

  phoneNumber: string = '';
  password: string = '';

  onPhoneNumberChange() {

  }

  login() {

    debugger
   
    
    const loginDTO:LoginDTO = {
  
      "phone_number" : this.phoneNumber,
      "password" : this.password

    }

    this.userService.login(loginDTO).subscribe(
      {
        next: (response: any) => {

          debugger
          // dang ky thanh cong chuyen sang man hinh login
          //this.router.navigate(['/login']);
          
        },
        complete: () => {
          debugger
        },
        error: (err:any) => {
          // xu ly loi neu co
          alert(`Can not register, error: ${err.error}`);
          
        },
      }
    );

  }

}
