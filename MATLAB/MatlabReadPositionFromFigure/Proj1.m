function varargout = Proj1(varargin)
% PROJ1 MATLAB code for Proj1.fig
%      PROJ1, by itself, creates a new PROJ1 or raises the existing
%      singleton*.
%
%      H = PROJ1 returns the handle to a new PROJ1 or the handle to
%      the existing singleton*.
%
%      PROJ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ1.M with the given input arguments.
%
%      PROJ1('Property','Value',...) creates a new PROJ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Proj1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Proj1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Proj1

% Last Modified by GUIDE v2.5 15-Jun-2013 15:21:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proj1_OpeningFcn, ...
                   'gui_OutputFcn',  @Proj1_OutputFcn, ...
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

% --- Executes just before Proj1 is made visible.
function Proj1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proj1 (see VARARGIN)

% Choose default command line output for Proj1
clc
mydata.test = 999;
mydata.x0_input = str2double(get(handles.edit1,'String'));
mydata.y0_input = str2double(get(handles.edit2,'String'));
mydata.xmax_input = str2double(get(handles.edit3,'String'));
mydata.ymax_input = str2double(get(handles.edit4,'String'));

handles.output = hObject;

% Update handles structure
guidata(hObject, mydata);
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Proj1.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
    %guidata(hObject,mydata);
end

% UIWAIT makes Proj1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Proj1_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
axes(handles.axes1);
cla;
popup_sel_index = get(handles.popupmenu1, 'Value')

switch popup_sel_index
    case 1
        mydata.x0 = 0;
        mydata.y0 = 0;
        mydata.xmax = 0;
        mydata.ymax = 0;
        mydata.NClick = 0;
        mydata.N = 0;
%         fig1 = imread('PlotVTD_All6Cases.tif');
%         fig1 = imread('Vit106_SS.jpg'); %PS85k_tau
        fig1 = imread('Vit1_T643_Fig14a.png'); %PS85k_tau        
        imageHandle = imshow(fig1);
        ParentImageHandle = get(imageHandle,'Parent');
        guidata(hObject,mydata);
%         guidata(imageHandle,mydata);
        sprintf('click on the figure')
        set(imageHandle,'ButtonDownFcn',@ImageClickCallback);
    case 2
        plot(rand(5));
    case 3
        plot(sin(1:0.01:25.99));
    case 4
        bar(1:.5:10);
    case 5
        plot(membrane);
    case 6
        surf(peaks);
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Load Image','plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function ImageClickCallback(objectHandle, eventData)
   axesHandle  = get(objectHandle,'Parent');
   hObject = get(axesHandle,'Parent');
   coordinates = get(axesHandle,'CurrentPoint'); 
   coordinates = coordinates(1,1:2)
   x = coordinates(1);
   y = coordinates(2);
   mydata = guidata(hObject);
   mydata.NClick = mydata.NClick + 1;
   if mydata.NClick==1
       mydata.x0 = x;
       mydata.y0 = y;
       sprintf('click xmax')
   elseif mydata.NClick == 2
       mydata.xmax = x;
       sprintf('click ymax')
   elseif mydata.NClick == 3
       mydata.ymax = y;
       sprintf('click data points')
   elseif mydata.NClick >3
       mydata.N = mydata.N + 1;
       mydata.x(mydata.N) = x;
       mydata.y(mydata.N) = y;
   end
   
   guidata(hObject,mydata);
   hold on
   plot(axesHandle,x,y,'or','MarkerSize',3,'LineWidth',3);
  
   
   

   
   


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    clc
    mydata = guidata(hObject);
    sprintf('Total number of data points = %ld',mydata.N)
    mydata.x
    mydata.y
    sprintf('New value x0 = %ld',mydata.x0_input)
    sprintf('New value y0 = %ld',mydata.y0_input)
    sprintf('New value xmax = %ld',mydata.xmax_input)
    sprintf('New value ymax = %ld',mydata.ymax_input)
    mydata.xp = ones(mydata.N,1).*0;
    mydata.yp = ones(mydata.N,1).*0;
    sprintf('\n\n Data points in the new coordinates are')
    for i=1:mydata.N
        mydata.xp(i) = mydata.x0_input + (mydata.x(i)-mydata.x0)/(mydata.xmax - mydata.x0)*(mydata.xmax_input-mydata.x0_input);
        mydata.yp(i) = mydata.y0_input + (mydata.y(i)-mydata.y0)/(mydata.ymax - mydata.y0)*(mydata.ymax_input-mydata.y0_input);
        temp = sprintf('%ld %ld',mydata.xp(i),mydata.yp(i));
        disp(temp)
    end

    





function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
    hObjectParent = get(hObject,'Parent');
    mydata = guidata(hObjectParent);
    mydata.x0_input = str2double(get(hObject,'String'));
    guidata(hObjectParent,mydata);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
    hObjectParent = get(hObject,'Parent');
    mydata = guidata(hObjectParent);
    mydata.y0_input = str2double(get(hObject,'String'));
    guidata(hObjectParent,mydata);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
    hObjectParent = get(hObject,'Parent');
    mydata = guidata(hObjectParent);
    mydata.xmax_input = str2double(get(hObject,'String'));
    guidata(hObjectParent,mydata);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
    hObjectParent = get(hObject,'Parent');
    mydata = guidata(hObjectParent);
    mydata.ymax_input = str2double(get(hObject,'String'));
    guidata(hObjectParent,mydata);

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit3 and none of its controls.
function edit3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
