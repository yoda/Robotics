function varargout = standford3dofPLAY(varargin)
% STANDFORD3DOFPLAY M-file for standford3dofPLAY.fig
%      STANDFORD3DOFPLAY, by itself, creates a new STANDFORD3DOFPLAY or raises the existing
%      singleton*.
%
%      H = STANDFORD3DOFPLAY returns the handle to a new STANDFORD3DOFPLAY or the handle to
%      the existing singleton*.
%
%      STANDFORD3DOFPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STANDFORD3DOFPLAY.M with the given input arguments.
%
%      STANDFORD3DOFPLAY('Property','Value',...) creates a new STANDFORD3DOFPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before standford3dofPLAY_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to standford3dofPLAY_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help standford3dofPLAY

% Last Modified by GUIDE v2.5 15-Mar-2010 07:28:07

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @standford3dofPLAY_OpeningFcn, ...
                   'gui_OutputFcn',  @standford3dofPLAY_OutputFcn, ...
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



% --- Executes just before standford3dofPLAY is made visible.
function standford3dofPLAY_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to standford3dofPLAY (see VARARGIN)

% Choose default command line output for standford3dofPLAY
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

pData.radincrement = pi/20;

pData.joint1 = 0;
pData.joint2 = 0;
pData.d3extend = pData.radincrement * 20;
pData.revolveX = 0;
pData.revolveY = 0;

pData.joint1b = 0;
pData.joint2b = 0;
pData.d3extendb = 0;
pData.revolveb = 0;


%rotate3d on; %doesnt work!
setappdata(hObject, 'paramData', pData);
value = pData;
standford3dof(value.joint1,value.joint2,value.d3extend,'coordframe', 1);

% UIWAIT makes standford3dofPLAY wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = standford3dofPLAY_OutputFcn(hObject, eventdata, handles) 
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
    value.d3extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '2')
    value.joint1b = 0;
    value.joint2b = 1;
    value.d3extendb = 0;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, '3')
    value.joint1b = 0;
    value.joint2b = 0;
    value.d3extendb = 1;
    value.revolveb = 0;
elseif strcmp(eventdata.Key, 'v')
    value.joint1b = 0;
    value.joint2b = 0;
    value.d3extendb = 0;
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
elseif value.d3extendb == 1
    if strcmp(eventdata.Key, 'downarrow')
        value.d3extend = value.d3extend - value.radincrement;
    elseif strcmp(eventdata.Key, 'uparrow')
        value.d3extend = value.d3extend + value.radincrement;
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
standford3dof(value.joint1,value.joint2,value.d3extend,'coordframe', 1);
setappdata(hObject, 'paramData', value);
