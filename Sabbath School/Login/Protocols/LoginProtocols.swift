/*
 * Copyright (c) 2017 Adventech <info@adventech.io>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import AsyncDisplayKit
import Firebase

protocol LoginPresenterProtocol: AnyObject {
    var controller: LoginControllerProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    var wireFrame: LoginWireFrameProtocol? { get set }

    func configure()
    func loginActionAnonymous()
    func loginActionGoogle()
    func loginActionFacebook()
    func performFirebaseLogin(credential: AuthCredential)
    
    @available(iOS 13, *) func loginActionApple()
}

protocol LoginControllerProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
}

protocol LoginWireFrameProtocol: AnyObject {
    static func createLoginModule() -> LoginController
    func presentQuarterlyScreen()
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func onError(_ error: Error?)
    func onSuccess()
}

protocol LoginInteractorInputProtocol: AnyObject {
    var presenter: LoginInteractorOutputProtocol? { get set }

    func configure()
}
