import { LoginDTO } from '../../dtos/user/login.dto';
import { Router } from '@angular/router';
import { UserService } from '../../services/user.service';
import { NgForm } from '@angular/forms';
import { Component, ViewChild } from '@angular/core';
import { LoginResponse } from 'src/app/responses/user/login.response';
import { TokenService } from 'src/app/services/token.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {

  @ViewChild('loginForm') loginForm!: NgForm;

  constructor(
    private router: Router, 
    private userService: UserService,
    private tokenService:TokenService
  ) {

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
        next: (response: LoginResponse) => {

          debugger
          const {token} = response;
          this.tokenService.setToken(token);
          
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
