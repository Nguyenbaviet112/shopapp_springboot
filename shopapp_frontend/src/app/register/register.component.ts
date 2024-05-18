import { Component, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import {HttpClient, HttpHeaders} from '@angular/common/http'
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent {

  @ViewChild('registerForm') registerForm!: NgForm;
  // Khai bao cac bien tuong ung voi cac truong du lieu trong form
  phoneNumber: string;
  password: string;
  retypePassword: string;
  fullName: string;
  address: string;
  isAccepted: boolean;
  dateOfBirth: Date;


  constructor(private http: HttpClient, private router: Router) {
    this.phoneNumber = ''; 
    this.password = '';
    this.retypePassword = '';
    this.fullName = '';
    this.address = '';
    this.isAccepted = false;
    this.dateOfBirth = new Date();
    this.dateOfBirth.setFullYear(this.dateOfBirth.getFullYear() - 18);

  }

  onPhoneNumberChange() {

  }

  register() {

    debugger
    const apiUrl = "localhost:8088/api/v1/users/register";
    const registerData = {
      "fullname" : this.fullName,
      "phone_number" : this.phoneNumber,
      "address" : this.address,
      "password" : this.password,
      "retype_password" : this.retypePassword,
      "date_of_birth" : this.dateOfBirth,
      "facebook_account_id" : 0,
      "google_account_id" : 0,
      "role_id" : 1
    }

    const headers = new HttpHeaders({'Content-Type': 'application/json'});
    this.http.post(apiUrl, registerData, {headers})
      .subscribe({
        next: (response: any) => {
          debugger
          // xu ly ket qua tra ve khi dang ky thanh cong
          if (response && (response.status === 200 || response.status === 201))
          {
            // dang ky thanh cong chuyen sang man hinh login
            this.router.navigate(['/login']);
          }
          else {
            // xu ly truong hop dang ky khong thanh cong neu can
          }
        },
        complete: () => {
          debugger
        },
        error: (err:any) => {
          // xu ly loi neu co
          alert(`Can not register, error: ${err.error}`);
          
        },
      });
    
  }

  // how to check password match.
  checkPasswordsMatch()
  {
    if (this.password != this.retypePassword)
    {
      this.registerForm.form.controls['retypePassword'].setErrors({'passwordMismatch': true});
    }
    else
    {
      this.registerForm.form.controls['retypePassword'].setErrors(null);
    }
  }

  checkAge()
  {
    if (this.dateOfBirth)
    {
      const today = new Date();
      const birthDate = new Date(this.dateOfBirth);
      let age = today.getFullYear() - birthDate.getFullYear();
      const monthDiff = today.getMonth() - birthDate.getMonth();
      if (monthDiff < 0 || monthDiff == 0 && today.getDate() < birthDate.getDate())
      {
        age--;
      }

      if (age < 18)
      {
        this.registerForm.form.controls['dateOfBirth'].setErrors({ 'invalidAge': true});
      }
      else {
        this.registerForm.form.controls['dateOfBirth'].setErrors(null);
      }


    }
  }

}
