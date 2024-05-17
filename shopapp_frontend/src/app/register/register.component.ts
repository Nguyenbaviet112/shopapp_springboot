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
  phone: string;
  password: string;
  retypePassword: string;
  fullName: string;
  address: string;
  isAccepted: boolean;
  dateOfBirth: Date;


  constructor(private http: HttpClient, private router: Router) {
    this.phone = '';
    this.password = '';
    this.retypePassword = '';
    this.fullName = '';
    this.address = '';
    this.isAccepted = false;
    this.dateOfBirth = new Date();
    this.dateOfBirth.setFullYear(this.dateOfBirth.getFullYear() - 18);

  }

  onPhoneChange() {

  }

  register() {
    const apiUrl = "localhost:8088/api/v1/users/register";
    
  }

  // how to check password match.
  checkPasswordMatch()
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
