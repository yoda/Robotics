function varargout = standford6dofPLAY(varargin)
% STANDFORD6DOFPLAY M-file for standford6dofPLAY.fig
%      STANDFORD6DOFPLAY, by itself, creates a new STANDFORD6DOFPLAY or raises the existing
%      singleton*.
%
%      H = STANDFORD6DOFPLAY returns the handle to a new STANDFORD6DOFPLAY or the handle to
%      the existing singleton*.
%
%      STANDFORD6DOFPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STANDFORD6DOFPLAY.M with the given input arguments.
%
%      STANDFORD6DOFPLAY('Property','Value',...) creates a new STANDFORD6DOFPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before standford6dofPLAY_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to standford6dofPLAY_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help standford6dofPLAY

% Last Modified by GUIDE v2.5 15-Mar-2010 11:42:43

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @standford6dofPLAY_OpeningFcn, ...
                   'gui_OutputFcn',  @standford6dofPLAY_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before standford6dofPLAY is made visible.
function standford6dofPLAY_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to standford6dofPLAY (see VARARGIN)

% Choose default command line output for standford6dofPLAY
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

pData.radincrement = pi/20;

pData.joint1 = 0;
pData.joint2 = 0;
pData.joint3 = 0;
pData.joint4 = 0;
pData.joint5 = 0;
pData.d3extend = pData.radincrement * 20;
pData.d2extend = pData.radincrement * 10;
pData.revolveX = 0;
pData.revolveY = 0;

pData.joint1b = 0;
pData.joint2b = 0;
pData.joint3b = 0;
pData.joint4b = 0;
pData.joint5b = 0;
pData.d3extendb = 0;
pData.d3extendb = 0;
pData.revolveb = 0;


%rotate3d on; %doesnt work!
setappdata(hObject, 'paramData', pData);
value = pData;
standford6dof(value.joint1,value.joint2,value.joint3,value.joint4,value.joint5,value.d2extend, value.d3extend,'coordframe', 1);

% UIWAIT makes standford6dofPLAY wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = standford6dofPLAY_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = handles.output;


% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
value = getappdata(hObject,'paramData');
disp(eventdata.Key);
if strcmp(eventdata.Key, '1')
    value.joint1b = 1;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d2extendb = 0;
    value.d3extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '2')
    value.joint1b = 0;
    value.joint2b = 1;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d2extendb = 0;
    value.d3extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '3')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d2extendb = 0;
    value.d3extendb = 1;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '4')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 1;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d2extendb = 0;
    value.d3extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '5')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 1;
    value.joint5b = 0;
    value.d3extendb = 0;
    value.d2extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '6')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 1;
    value.d3extendb = 0;
    value.d2extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '7')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d3extendb = 0;
    value.d2extendb = 1;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, 'v')
    value.joint1b = 0;
    value.joint2b = 0;
    value.joint3b = 0;
    value.joint4b = 0;
    value.joint5b = 0;
    value.d3extendb = 0;
    value.d2extendb = 0;
    value.revolveb = 1;
end
if value.joint1b == 1
    if strcmp(eventdata.Key, 'downarrow')
    elseif strcmp(eventdata.Key, 'uparrow')
    elseif strcmp(eventdata.Key, 'rightarrow')
        value.joint1 = value.joint1 + value.radincrement;
    elseif strcmp(eventdata.Key, 'leftarrow')
        value.joint1 = value.joint1 - value.radincrement;
    end
elseif value.joint2b == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.joint2 = value.joint2 - value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.joint2 = value.joint2 + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.joint3b == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.joint3 = value.joint3 - value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.joint3 = value.joint3 + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.joint4b == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.joint4 = value.joint4 - value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.joint4 = value.joint4 + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.joint5b == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.joint5 = value.joint5 - value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.joint5 = value.joint5 + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.d3extendb == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.d3extend = value.d3extend - value.radincrement;
        if value.d3extend < 0
            value.d3extend = 0;
        end
    elseif strcmp(eventdata.Key, 'uparrow')
        value.d3extend = value.d3extend + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.d2extendb == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.d2extend = value.d2extend - value.radincrement;
        if value.d2extend < 0
            value.d2extend = 0;
        end
    elseif strcmp(eventdata.Key, 'uparrow')
        value.d2extend = value.d2extend + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
    elseif strcmp(eventdata.Key, 'leftarrow')
    end
elseif value.revolveb == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.revolveY = value.revolveY + value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.revolveY = value.revolveY + value.radincrement;
    elseif strcmp(eventdata.Key, 'rightarrow')
        value.revolveX = value.revolveX + value.radincrement;
    elseif strcmp(eventdata.Key, 'leftarrow')
        value.revolveX = value.revolveX + value.radincrement;
    end
end
clf(gcf)
standford6dof(value.joint1,value.joint2,value.joint3,value.joint4,value.joint5,value.d2extend,value.d3extend,'coordframe', 1);
setappdata(hObject, 'paramData', value);
